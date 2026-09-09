import Mathlib
import BookProof.ChapterA3

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"On the Lorentz, SL(2,C) and Pin(3,1) groups", Definition 49 — the discrete Pin
subgroup `Ω` is the **double cover** of the discrete Lorentz subgroup `Δ`

`book.tex` (Definition 49, line ~5510) introduces the discrete `Pin(3,1)` subgroup

```
Ω = { ±1, ±iγ⁰, ±γ⁰γ⁵, ±iγ⁵ }
```

and asserts that, via the two-to-one cover `Λ : Pin(3,1) → O(1,3)`, it is the
**double cover of the Klein-four discrete Lorentz subgroup**
`Δ = { 1, η, -η, -1 }` (`η = diag(1,-1,-1,-1)`).  Wave 84
(`BookProof.ChapterPinOmega`) pinned down the *group* structure of `Ω` (order 8,
the quaternion relations); this file discharges the remaining finite core of
Definition 49 — the **covering map** `Λ : Ω → Δ` itself.

For `S ∈ Pin(3,1)` the cover is defined by the conjugation action on the Majorana
basis, `S⁻¹ (iγ^μ) S = Λ(S)^μ_ν (iγ^ν)`.  Rewritten without inverses (multiply
by `S` on the left), this reads

```
(iγ^μ) · S = S · ( Σ_ν Λ(S)^μ_ν (iγ^ν) )
```

which over the integer Majorana model `mgammaZ` is fully decidable.  We give the
explicit integer matrix `LamZ S` for every `S ∈ Ω` and prove:

* `LamZ_spec` — the defining conjugation relation above (this *validates* the
  formula for `LamZ`);
* `LamZ_mem_Delta` — `Λ` maps `Ω` into `Δ`;
* `LamZ_surjective` — `Λ` maps `Ω` **onto** `Δ` (`Δ = Ω.image LamZ`);
* `LamZ_hom` — `Λ` is a **homomorphism** on `Ω` (`Λ(ST) = Λ(S)Λ(T)`);
* `LamZ_neg` and `LamZ_fiber_card` — `Λ(S) = Λ(-S)` and every fibre has exactly
  **2** elements, i.e. `Λ` is genuinely **two-to-one**;

so `Λ : Ω → Δ` is a surjective 2-to-1 homomorphism — the double cover of
Definition 49.  The concrete images are

```
±1 ↦ 1,   ±iγ⁰ ↦ η,   ±γ⁰γ⁵ ↦ -η,   ±iγ⁵ ↦ -1 .
```

Everything is carried out over `ℤ` (decidable) and the conjugation relation is
transported to the complex Majorana matrices `mgamma` in `LamZ_spec_C`.
`etaZ_eq_mink` connects the integer `η` used here with the Minkowski metric
`minkowskiZ` of `BookProof.ChapterA3`.

As requested this stays **off the gravity line** and **off the Hankel-transform
line** (it uses only the concrete Majorana / Dirac matrices, no spherical-Bessel
/ Hankel numerics).

Everything is `sorry`-free and `axiom`-free.
-/

open Matrix

namespace BookProof.ChapterPinDoubleCover

open BookProof.ChapterA3

/-! ## The generators of `Ω` and the discrete Lorentz group `Δ` (integer model) -/

/-- `qi = iγ⁰` (the first Majorana matrix), integer model. -/
def qi : Matrix (Fin 4) (Fin 4) ℤ := mgammaZ 0

/-- `qj = γ⁰γ⁵ = -(iγ⁰)(iγ⁵)`, integer model. -/
def qj : Matrix (Fin 4) (Fin 4) ℤ := -(mgammaZ 0 * mgamma5Z)

/-- `qk = iγ⁵` (the fifth Majorana matrix), integer model. -/
def qk : Matrix (Fin 4) (Fin 4) ℤ := mgamma5Z

/-- The Minkowski metric `η = diag(1,-1,-1,-1)`, integer model. -/
def etaZ : Matrix (Fin 4) (Fin 4) ℤ := !![1,0,0,0; 0,-1,0,0; 0,0,-1,0; 0,0,0,-1]

/-- `η` is exactly the Minkowski metric matrix `minkowskiZ` of `ChapterA3`. -/
theorem etaZ_eq_mink : etaZ = Matrix.of (fun μ ν => minkowskiZ μ ν) := by decide

/-- The discrete Pin subgroup `Ω = {±1, ±iγ⁰, ±γ⁰γ⁵, ±iγ⁵}` (integer model). -/
def Omega : Finset (Matrix (Fin 4) (Fin 4) ℤ) := {1, -1, qi, -qi, qj, -qj, qk, -qk}

/-- The discrete Lorentz subgroup `Δ = {1, η, -η, -1}` (integer model). -/
def Delta : Finset (Matrix (Fin 4) (Fin 4) ℤ) := {1, etaZ, -etaZ, -1}

theorem Omega_card : Omega.card = 8 := by decide
theorem Delta_card : Delta.card = 4 := by decide

/-! ## The covering map `Λ : Ω → Δ` -/

/-- The Lorentz matrix `Λ(S)` induced by the conjugation action of `S ∈ Ω` on the
Majorana basis.  Explicitly `±1 ↦ 1`, `±iγ⁰ ↦ η`, `±γ⁰γ⁵ ↦ -η`, `±iγ⁵ ↦ -1`. -/
noncomputable def LamZ (S : Matrix (Fin 4) (Fin 4) ℤ) : Matrix (Fin 4) (Fin 4) ℤ :=
  if S = 1 ∨ S = -1 then 1
  else if S = qi ∨ S = -qi then etaZ
  else if S = qj ∨ S = -qj then -etaZ
  else if S = qk ∨ S = -qk then -1
  else 1

open Classical in
/-- **Defining conjugation relation** (validating the formula for `LamZ`):
for every `S ∈ Ω`, `(iγ^μ) S = S (Σ_ν Λ(S)^μ_ν iγ^ν)` — equivalently
`S⁻¹ (iγ^μ) S = Λ(S)^μ_ν iγ^ν`. -/
theorem LamZ_spec :
    ∀ S ∈ Omega, ∀ μ : Fin 4,
      mgammaZ μ * S = S * (∑ ν : Fin 4, (LamZ S) μ ν • mgammaZ ν) := by
  decide

open Classical in
/-- `Λ` maps `Ω` into the discrete Lorentz group `Δ`. -/
theorem LamZ_mem_Delta : ∀ S ∈ Omega, LamZ S ∈ Delta := by decide

open Classical in
/-- `Λ` maps `Ω` **onto** `Δ`. -/
theorem LamZ_surjective : Delta = Omega.image LamZ := by decide

open Classical in
/-- `Λ` is a **homomorphism** on `Ω`: `Λ(S·T) = Λ(S)·Λ(T)`. -/
theorem LamZ_hom : ∀ S ∈ Omega, ∀ T ∈ Omega, LamZ (S * T) = LamZ S * LamZ T := by decide

open Classical in
/-- `Λ` is invariant under the central `±1`: `Λ(S) = Λ(-S)`. -/
theorem LamZ_neg : ∀ S ∈ Omega, LamZ S = LamZ (-S) := by decide

open Classical in
/-- **Two-to-one**: every fibre of `Λ : Ω → Δ` has exactly two elements. -/
theorem LamZ_fiber_card :
    ∀ d ∈ Delta, (Omega.filter (fun S => LamZ S = d)).card = 2 := by decide

/-! ## The conjugation relation transported to the complex Majorana model -/

open Classical in
/-- The defining conjugation relation `LamZ_spec` transported to the complex
Majorana matrices `mgamma`: for `S ∈ Ω`,
`(iγ^μ) · (S : ℂ) = (S : ℂ) · (Σ_ν Λ(S)^μ_ν iγ^ν)`. -/
theorem LamZ_spec_C :
    ∀ S ∈ Omega, ∀ μ : Fin 4,
      mgamma μ * (Int.castRingHom ℂ).mapMatrix S
        = (Int.castRingHom ℂ).mapMatrix S * (∑ ν : Fin 4, (LamZ S) μ ν • mgamma ν) := by
  intro S hS μ
  have h := LamZ_spec S hS μ
  have h2 := congrArg (Int.castRingHom ℂ).mapMatrix h
  rw [map_mul, map_mul, map_sum] at h2
  simp only [map_zsmul] at h2
  simpa [mgamma] using h2

end BookProof.ChapterPinDoubleCover
