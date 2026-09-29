-- Generated from ChapterSirkGramCutoff.lean — solution of BookProof.ChapterSirkGramCutoff.synthesis_isometry_of_orthonormal
import Mathlib
import Definitions.Def_ChapterSirkGramCutoff
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_adjoint_comp_self_of_inner
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_synthesis_apply
import Definitions.Def_ChapterSirkGramWhitening
open BookProof.ChapterSirkGramCutoff










noncomputable section


open scoped InnerProductSpace
open BookProof.ChapterSirkGramWhitening
open ContinuousLinearMap

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]






variable {m : ℕ} {w : Fin m → E}
variable {u : OrthonormalBasis (Fin m) ℂ (EuclideanSpace ℂ (Fin m))} {lam : Fin m → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {d : ℕ} {v : Fin d → E} (hv : Orthonormal ℂ v) :
    (adjoint (synthesis v)).comp (synthesis v)
      = ContinuousLinearMap.id ℂ (EuclideanSpace ℂ (Fin d)) := by

  refine adjoint_comp_self_of_inner _ fun a b => ?_
  have hortho : ∀ i j, ⟪v i, v j⟫_ℂ = if i = j then (1 : ℂ) else 0 :=
    orthonormal_iff_ite.mp hv
  rw [synthesis_apply, synthesis_apply, sum_inner]
  have hstep : ∀ i : Fin d, ⟪a i • v i, ∑ j, b j • v j⟫_ℂ
      = (starRingEnd ℂ) (a i) * b i := by
    intro i
    rw [inner_sum, Finset.sum_eq_single i]
    · rw [inner_smul_left, inner_smul_right, hortho i i, if_pos rfl, mul_one]
    · intro j _ hj
      rw [inner_smul_left, inner_smul_right, hortho i j, if_neg (Ne.symm hj)]
      ring
    · intro hi; exact absurd (Finset.mem_univ i) hi
  rw [Finset.sum_congr rfl fun i _ => hstep i]
  simp [PiLp.inner_apply, RCLike.inner_apply, mul_comm]
