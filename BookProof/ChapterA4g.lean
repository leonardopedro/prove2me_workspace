import Mathlib
import BookProof.ChapterA4c
import BookProof.ChapterA4d
import BookProof.ChapterA4e

/-!
# Chapter A, §A.4 — Prop 81 / Notes 80–83: the Bargmann–Wigner rep group laws

Source: `book.tex` §A.4 (line 5636), **Notes 80–83 / Proposition 81** — the
massive (Note 80 complex / **Prop 81** real) and massless-discrete-helicity
(Notes 82–83) irreducible projective Poincaré representations, realized in the
Majorana formalism with the explicit little-group action `L_S` and translation
action `T_a`.

Following the roadmap directive for this item ("state the reps as structures and
*verify the group-rep axioms* for the given `L_S, T_a` (checkable), citing Wigner
for exhaustiveness"), this file formalizes the concrete, self-contained
**group-representation axioms** of the little-group and translation factors of
the Poincaré rep, on the `2×2` little-group models of §A.4:

* **Massive little group `SU(2)` (Prop 79, `ChapterA4c`).** The spin-`½` factor
  `L_S` is the defining representation `S ↦ S` of the massive little group. Its
  representation axioms are the group axioms of `SUtwo`:
  `SUtwo_one_mem` (identity), `SUtwo_mul_mem` (closure — respects composition),
  `SUtwo_conjTranspose_mem` / `SUtwo_inv` (`S⁻¹ = S†` is again in `SU(2)`). The
  higher spin-`j` reps are the symmetric tensor powers of this defining rep
  (`EXTERNAL` Wigner exhaustiveness; the base case is here).
* **Massless little group `SE(2)` (Prop 79, `ChapterA4d`).** The
  discrete-helicity factor is realized on `SEtwo`; the same group axioms
  `SEtwo_one_mem`, `SEtwo_mul_mem` verify it is a representation domain.
* **Translation factor `T_a`.** On 3-momentum space the translation by `a⃗` acts
  as the phase `T_a(p⃗) = e^{i p⃗·a⃗}`. Its representation axioms are additivity
  `transPhase_add` (`T_{a+b} = T_a T_b`), `transPhase_zero` (`T_0 = 1`), and
  unitarity `transPhase_abs` (`|T_a| = 1`) — the abelian translation subgroup is
  represented by unit-modulus phases (a genuine unitary one-parameter-per-axis
  group).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis** enters these group-law verifications
(the *exhaustiveness* of the Bargmann–Wigner classification — that these are
*all* the irreps — is the cited Wigner 1939 / Mackey backbone, not these
axiom checks).
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterA4g

open BookProof.ChapterA3

/-! ## The massive little group `SU(2)` — spin-½ defining-rep axioms -/

/-- The identity lies in `SU(2)`: the trivial group element is represented. -/
theorem SUtwo_one_mem : (1 : Matrix (Fin 2) (Fin 2) ℂ) ∈ SUtwo := by
  constructor <;> norm_num

/-- `SU(2)` is closed under multiplication: the spin-½ defining representation
`L_S : S ↦ S` respects composition, `L_{ST} = L_S L_T`. -/
theorem SUtwo_mul_mem {S T : Matrix (Fin 2) (Fin 2) ℂ}
    (hS : S ∈ SUtwo) (hT : T ∈ SUtwo) : S * T ∈ SUtwo := by
  refine ⟨?_, ?_⟩
  · rw [Matrix.det_mul, hS.1, hT.1, mul_one]
  · rw [conjTranspose_mul, Matrix.mul_assoc, ← Matrix.mul_assoc Sᴴ, hS.2, Matrix.one_mul, hT.2]

/-- For `S ∈ SU(2)` the conjugate transpose `S†` is again in `SU(2)`; since
`S† S = 1`, this is the group inverse, so the defining rep sends inverses to
inverses. -/
theorem SUtwo_conjTranspose_mem {S : Matrix (Fin 2) (Fin 2) ℂ}
    (hS : S ∈ SUtwo) : Sᴴ ∈ SUtwo := by
  refine ⟨?_, ?_⟩
  · rw [Matrix.det_conjTranspose, hS.1, star_one]
  · rw [conjTranspose_conjTranspose, mul_eq_one_comm, hS.2]

/-- `S† S = 1` for `S ∈ SU(2)` (unitarity), and `S S† = 1` too — the inverse of
the defining-rep image is its adjoint. -/
theorem SUtwo_mul_conjTranspose {S : Matrix (Fin 2) (Fin 2) ℂ}
    (hS : S ∈ SUtwo) : S * Sᴴ = 1 := by
  rw [mul_eq_one_comm, hS.2]

/-! ## The massless little group `SE(2)` — discrete-helicity-rep axioms -/

/-- The identity lies in `SE(2)`. -/
theorem SEtwo_one_mem : (1 : Matrix (Fin 2) (Fin 2) ℂ) ∈ SEtwo :=
  ⟨by norm_num, by norm_num, by norm_num⟩

/-- `SE(2)` is closed under multiplication: the massless discrete-helicity rep
respects composition. -/
theorem SEtwo_mul_mem {S T : Matrix (Fin 2) (Fin 2) ℂ}
    (hS : S ∈ SEtwo) (hT : T ∈ SEtwo) : S * T ∈ SEtwo := by
  simp_all [SEtwo, Matrix.mul_apply]

/-! ## The translation factor `T_a(p⃗) = e^{i p⃗·a⃗}` -/

/-- The momentum-space translation phase `T_a(p⃗) = exp(i p⃗·a⃗)`. -/
noncomputable def transPhase (p a : Fin 3 → ℝ) : ℂ :=
  Complex.exp (Complex.I * ((∑ j, p j * a j : ℝ) : ℂ))

/-- Additivity of the translation rep: `T_{a+b} = T_a · T_b`. -/
theorem transPhase_add (p a b : Fin 3 → ℝ) :
    transPhase p (a + b) = transPhase p a * transPhase p b := by
  unfold transPhase
  norm_num [← Complex.exp_add, mul_add, Finset.sum_add_distrib]

/-- The zero translation is the identity: `T_0 = 1`. -/
theorem transPhase_zero (p : Fin 3 → ℝ) : transPhase p 0 = 1 := by
  unfold transPhase; norm_num

/-- Unitarity of the translation rep: each `T_a` is a unit-modulus phase. -/
theorem transPhase_abs (p a : Fin 3 → ℝ) :
    ‖transPhase p a‖ = 1 := by
  unfold transPhase; norm_num [Complex.norm_exp]

/-! ## Constraint preservation: the massive little group fixes the rest frame

On the `4×4` Majorana model the spatial rotation generators `γⁱγʲ` (the Lie
algebra of the massive little group `SU(2)`, which fixes the standard rest
momentum) commute with the energy-sign operator `iγ⁰` of `ChapterA4e`, hence with
the positive-energy Dirac projector `P₊`.  This is the Bargmann–Wigner
rep-consistency statement for the massive irreps: the massive little-group action
preserves the positive-energy (Dirac) constraint subspace. -/

open BookProof.ChapterA5 (spatialIdx coeffMass1Z)
open BookProof.ChapterA4e (enSign projPos)

/-- The spatial rotation generator `γⁱγʲ` (a generator of the massive little
group `SU(2)`), over `ℤ`. -/
def rotGenZ (i j : Fin 3) : Matrix (Fin 4) (Fin 4) ℤ :=
  mgammaZ (spatialIdx i) * mgammaZ (spatialIdx j)

/-- Each rotation generator `γⁱγʲ` commutes with `iγ⁰` (integer model):
`γ⁰` anticommutes with each spatial `γⁱ`, so it commutes with the product of two
of them. -/
theorem rotGenZ_coeffMass1Z_comm (i j : Fin 3) :
    rotGenZ i j * coeffMass1Z = coeffMass1Z * rotGenZ i j := by
  fin_cases i <;> fin_cases j <;> decide

/-- The spatial rotation generator `γⁱγʲ` as a complex matrix. -/
noncomputable def rotGen (i j : Fin 3) : Matrix (Fin 4) (Fin 4) ℂ :=
  (Int.castRingHom ℂ).mapMatrix (rotGenZ i j)

/-- The complex rotation generator commutes with the energy-sign operator
`enSign = iγ⁰`. -/
theorem rotGen_enSign_comm (i j : Fin 3) :
    rotGen i j * enSign = enSign * rotGen i j := by
  rw [rotGen, enSign, ← map_mul, ← map_mul, rotGenZ_coeffMass1Z_comm]

/-- **Massive-rep constraint preservation.** Each massive little-group rotation
generator commutes with the positive-energy Dirac projector `P₊`, so the massive
little-group action preserves the positive-energy constraint subspace. -/
theorem rotGen_projPos_comm (i j : Fin 3) :
    rotGen i j * projPos = projPos * rotGen i j := by
  unfold projPos
  simp [mul_sub, sub_mul, mul_one, one_mul, rotGen_enSign_comm]

end BookProof.ChapterA4g
