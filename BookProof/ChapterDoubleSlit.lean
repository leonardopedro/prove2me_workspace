import Mathlib

/-!
# Chapter "Reconstructing the classical trajectory of any isolated quantum system"
— the Young's double-slit experiment as an involutive unitary

Source: `book.tex`, chapter *"Reconstructing the classical trajectory of any
isolated quantum system"*, §*"The Young's double slit experiment"*
(`book.tex` line ~3082).

The book models the two-slit experiment for a two-state (two-angle) electron by
the normalized `2×2` Hadamard matrix

  `H = (1/√2) · [[1, 1], [1, -1]]`,

with initial wave-function `Ψ = (1, 0)` fired at the source `(S1)`.

* If the second slit is **closed**, the evolution `(S1) → (S2)` is the identity
  and the evolution `(S2) → (F)` is `H`, so the final state is `H·Ψ = (1/√2)(1,1)`
  giving the **uniform** Born distribution `(1/2, 1/2)` (the electron arrives
  along angle 1 or angle 2 with equal probability).
* If the second slit is **open**, the evolution `(S1) → (S2)` is `H` (the electron
  goes through both slits with equal probability) and `(S2) → (F)` is again `H`,
  so the final state is `H·(H·Ψ) = H²·Ψ = Ψ = (1, 0)` giving the **certain**
  Born distribution `(1, 0)` (the electron arrives only along angle 1).

The whole "mystery" of self-interference (`50/50` at the intermediate step
becoming `100/0` at the detector) is the purely algebraic fact that the Hadamard
matrix is an **involution**, `H² = 1`: composing the two non-deterministic
symmetry transformations produces certainty, which is *not* what a stochastic
process applying the two steps in sequence would give.

This file makes that self-contained content precise.  We reuse only the concrete
Hadamard matrix (as in `ChapterE.lean`); nothing here touches the gravity or the
γ/Majorana lines.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterDoubleSlit

/-- The normalized `2×2` Hadamard matrix — the double-slit time evolution. -/
noncomputable def H : Matrix (Fin 2) (Fin 2) ℂ :=
  (1 / Real.sqrt 2 : ℂ) • !![1, 1; 1, -1]

/-- The initial wave-function `Ψ = (1, 0)` fired at the source `(S1)`. -/
def psi0 : Fin 2 → ℂ := ![1, 0]

/-- The Born probability of component `i` of a wave-function `ψ`. -/
noncomputable def bornProb (ψ : Fin 2 → ℂ) (i : Fin 2) : ℝ := ‖ψ i‖ ^ 2

/-- The Hadamard matrix is unitary: `Hᴴ H = 1`. -/
theorem H_unitary : Hᴴ * H = 1 := by
  have h2 : (Real.sqrt 2 : ℂ) * (Real.sqrt 2 : ℂ) = 2 := by
    exact_mod_cast Real.mul_self_sqrt (by norm_num : (0:ℝ) ≤ 2)
  have hpos : (0:ℝ) < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
  have hne : (Real.sqrt 2 : ℂ) ≠ 0 := by exact_mod_cast hpos.ne'
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [H, Matrix.mul_apply, Matrix.conjTranspose_apply, Fin.sum_univ_two] <;>
    field_simp <;> (try linear_combination -h2)

/-- **The crux of the double-slit "mystery": the Hadamard evolution is an
involution, `H² = 1`.**  Composing the two non-deterministic steps gives the
identity. -/
theorem H_involutive : H * H = 1 := by
  have h2 : (Real.sqrt 2 : ℂ) * (Real.sqrt 2 : ℂ) = 2 := by
    exact_mod_cast Real.mul_self_sqrt (by norm_num : (0:ℝ) ≤ 2)
  have hpos : (0:ℝ) < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
  have hne : (Real.sqrt 2 : ℂ) ≠ 0 := by exact_mod_cast hpos.ne'
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [H, Matrix.mul_apply, Fin.sum_univ_two] <;>
    field_simp <;> (try linear_combination -h2)

/-- The intermediate/final state after applying `H` to `Ψ = (1, 0)` is the
uniform superposition `(1/√2)(1, 1)`. -/
theorem Hpsi0 : H *ᵥ psi0 = fun _ => (1 / Real.sqrt 2 : ℂ) := by
  funext i
  fin_cases i <;>
    simp [H, psi0, Matrix.mulVec, dotProduct, Fin.sum_univ_two, Matrix.smul_apply]

/-- **Slit closed.**  With the second slit closed the final state is `H·Ψ` and
its Born distribution is uniform, `(1/2, 1/2)`: the electron arrives along either
angle with equal probability. -/
theorem slit_closed_born (i : Fin 2) : bornProb (H *ᵥ psi0) i = 1 / 2 := by
  rw [Hpsi0]
  simp only [bornProb]
  rw [show (1 / Real.sqrt 2 : ℂ) = ((Real.sqrt 2 : ℝ):ℂ)⁻¹ by rw [one_div]]
  rw [norm_inv, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (Real.sqrt_nonneg 2), inv_pow,
    Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2)]
  norm_num

/-- **Slit open, state.**  With the second slit open the final state is
`H·(H·Ψ) = H²·Ψ = Ψ`: the two non-deterministic steps compose to the identity. -/
theorem slit_open_state : H *ᵥ (H *ᵥ psi0) = psi0 := by
  rw [Matrix.mulVec_mulVec, H_involutive, Matrix.one_mulVec]

/-- **Slit open, Born distribution.**  The final Born distribution is certain,
`(1, 0)`: the electron arrives only along angle 1 (constructive/destructive
self-interference). -/
theorem slit_open_born :
    bornProb (H *ᵥ (H *ᵥ psi0)) 0 = 1 ∧ bornProb (H *ᵥ (H *ᵥ psi0)) 1 = 0 := by
  rw [slit_open_state]
  refine ⟨?_, ?_⟩ <;> simp [bornProb, psi0]

end BookProof.ChapterDoubleSlit
