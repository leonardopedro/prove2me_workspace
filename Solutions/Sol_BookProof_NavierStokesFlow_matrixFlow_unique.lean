-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.matrixFlow_unique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_neg_hasDerivAt
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_mul_neg
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
<;> (first
      | rfl
      | (change A *ᵥ (matrixFlow A t *ᵥ x) = (matrixFlow A t * A) *ᵥ x
          <;> rw [matrixFlow_comm, ← Matrix.mulVec_mulVec])
      | simp [applyVecCLM, matrixFlow_comm, Matrix.mulVec_mulVec])

/-- **Uniqueness for the linear Cauchy problem.**  Any differentiable curve with
`ẏ(t) = A y(t)` for every `t` and `y(0) = x` is the orbit of the flow.  The
proof is the classical one: `t ↦ e^{−tA} y(t)` has vanishing derivative, hence :=
   is
  constant. -/
  theorem matrixFlow_unique (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) (y : ℝ → Fin n → ℂ)
      (hy : ∀ t, HasDerivAt y (A *ᵥ y t) t) (hy0 : y 0 = x) (t : ℝ) :
      y t = matrixFlow A t *ᵥ x := by
    have hzd : ∀ s : ℝ, HasDerivAt (fun s : ℝ => matrixFlow A (-s) *ᵥ y s) 0 s := by
      intro s
      have hV : HasDerivAt (fun s : ℝ => mulVecCLM' (matrixFlow A (-s)))
          (mulVecCLM' (-(matrixFlow A (-s) * A))) s :=
        mulVecCLM'.hasFDerivAt.comp_hasDerivAt s (matrixFlow_neg_hasDerivAt A s)
      have h := hV.clm_apply (hy s)
      have hrw : (mulVecCLM' (-(matrixFlow A (-s) * A))) (y s)
          + (mulVecCLM' (matrixFlow A (-s))) (A *ᵥ y s) = 0 := by
        change (-(matrixFlow A (-s) * A)) *ᵥ (y s) + (matrixFlow A (-s)) *ᵥ (A *ᵥ y s) = 0
        rw [Matrix.mulVec_mulVec]
        simp [Matrix.neg_mulVec]
      rw [hrw] at h
      exact h
    have hconst : matrixFlow A (-t) *ᵥ y t = matrixFlow A (-0) *ᵥ y 0 :=
      is_const_of_deriv_eq_zero (fun s => (hzd s).differentiableAt) (fun s => (hzd s).deriv) t 0
    have h0 : matrixFlow A (-t) *ᵥ y t = x := by
      rw [hconst, hy0]
      simp [matrixFlow, NormedSpace.exp_zer
