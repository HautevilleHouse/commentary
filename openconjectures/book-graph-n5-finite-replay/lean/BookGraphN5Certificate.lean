abbrev Poly := List Rat

def trim : Poly → Poly
  | [] => [0]
  | xs =>
      let ys := xs.reverse.dropWhile (fun q => q = 0)
      match ys.reverse with
      | [] => [0]
      | zs => zs

def degree (p : Poly) : Nat :=
  let q := trim p
  if q = [0] then 0 else q.length - 1

def add (a b : Poly) : Poly :=
  trim <| List.ofFn (fun i : Fin (max a.length b.length) =>
    a.getD i.1 0 + b.getD i.1 0)

def sub (a b : Poly) : Poly :=
  trim <| List.ofFn (fun i : Fin (max a.length b.length) =>
    a.getD i.1 0 - b.getD i.1 0)

def mul (a b : Poly) : Poly :=
  trim <| List.ofFn (fun k : Fin (a.length + b.length - 1) =>
    ((List.range (k.1 + 1)).foldl
      (fun acc i => acc + a.getD i 0 * b.getD (k.1 - i) 0) 0))

def pow : Poly → Nat → Poly
  | _, 0 => [1]
  | p, n + 1 => mul p (pow p n)

def deriv (p : Poly) : Poly :=
  trim <| (List.range (p.length - 1)).map (fun j => ((j + 1 : Nat) : Rat) * p.getD (j + 1) 0)

def monomialShift (k : Nat) (c : Rat) (p : Poly) : Poly :=
  List.replicate k 0 ++ p.map (fun x => c * x)

def divmodFuel : Nat → Poly → Poly → Poly × Poly
  | 0, a, _ => ([0], trim a)
  | fuel + 1, a, b =>
      let a' := trim a
      let b' := trim b
      if b' = [0] then ([0], a')
      else if a' = [0] then ([0], [0])
      else if degree a' < degree b' then ([0], a')
      else
        let k := degree a' - degree b'
        let c := a'.getLast! / b'.getLast!
        let qTerm := List.replicate k 0 ++ [c]
        let rNext := sub a' (monomialShift k c b')
        let (qRest, rFinal) := divmodFuel fuel rNext b'
        (add qTerm qRest, rFinal)

def gcdFuel : Nat → Poly → Poly → Poly
  | 0, a, _ => trim a
  | fuel + 1, a, b =>
      let b' := trim b
      if b' = [0] then
        let a' := trim a
        if a' = [0] then [0] else a'.map (fun x => x / a'.getLast!)
      else
        let (_, r) := divmodFuel (fuel + 8) a b'
        gcdFuel fuel b' r

def sturmFuel : Nat → Poly → List Poly
  | 0, p => [trim p]
  | fuel + 1, p =>
      let p' := trim p
      let dp := trim (deriv p')
      let rec loop : Nat → Poly → Poly → List Poly
        | 0, a, b => [trim a, trim b]
        | inner + 1, a, b =>
            let b' := trim b
            if b' = [0] then [trim a]
            else
              let (_, r) := divmodFuel (inner + 8) a b'
              trim a :: loop inner b' (r.map (fun x => -x))
      loop fuel p' dp

def evalPoly (p : Poly) (x : Rat) : Rat :=
  (List.range p.length).foldl (fun acc i => acc + p.getD i 0 * x^i) 0

def signRat (q : Rat) : Int :=
  if q = 0 then 0 else if q > 0 then 1 else -1

def signAtRational (p : Poly) (x : Rat) : Int :=
  signRat (evalPoly p x)

def signAtInfinity (p : Poly) (positive : Bool) : Int :=
  let q := trim p
  if q = [0] then 0
  else
    let base : Int := if q.getLast! > 0 then 1 else -1
    if positive then base else if degree q % 2 = 1 then -base else base

def variations (signs : List Int) : Nat :=
  let filtered := signs.filter (fun s => s ≠ 0)
  ((List.zip filtered (filtered.drop 1)).foldl
    (fun acc pair => if pair.1 ≠ pair.2 then acc + 1 else acc) 0)

inductive Endpoint where
  | negInf
  | rat : Rat → Endpoint
  | posInf

def signAtEndpoint (p : Poly) : Endpoint → Int
  | .negInf => signAtInfinity p false
  | .rat x => signAtRational p x
  | .posInf => signAtInfinity p true

def countInterval (seq : List Poly) (left right : Endpoint) : Nat :=
  let leftSigns := seq.map (fun p => signAtEndpoint p left)
  let rightSigns := seq.map (fun p => signAtEndpoint p right)
  variations leftSigns - variations rightSigns

def quotient : Poly := [1, 10, 45, 150, 354, 492, 410, 210, 66, 12, 1]

def x : Poly := [0, 1]

def one : Poly := [1]

def twoXPlusOne : Poly := [1, 2]

def xPlusOne : Poly := [1, 1]

def xPlusTwo : Poly := [2, 1]

def sourcePolynomial : Poly :=
  sub
    (add
      (mul twoXPlusOne (pow (mul x xPlusTwo) 5))
      (mul (pow x 2) (pow (pow xPlusOne 2) 5)))
    (mul [0, 0, 0, 0, 0, 2] one)

def expandedSourcePolynomial : Poly :=
  mul (pow x 2) quotient

def expectedGcd : Poly := [1]

def counts : List Nat :=
  let seq := sturmFuel 32 quotient
  [ countInterval seq .negInf (.rat (-2))
  , countInterval seq (.rat (-2)) (.rat (-1/2))
  , countInterval seq (.rat (-1/2)) (.rat 0)
  , countInterval seq .negInf .posInf
  ]

theorem quotient_gcd_and_counts_checked :
    gcdFuel 32 quotient (deriv quotient) = expectedGcd ∧
    counts = [0, 0, 2, 2] := by
  native_decide

theorem source_expansion_identity_checked :
    sourcePolynomial = expandedSourcePolynomial := by
  native_decide
