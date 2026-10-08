-- Generated from ChapterDiffuseUnitaryModel.lean — solution of BookProof.ChapterDiffuseUnitaryModel.diffuse_multiplication_model_uniform
import Mathlib
import Definitions.Def_ChapterDiffuseUnitaryModel
import Theorems.Thm_BookProof_ChapterDiffuseUnitaryModel_memLp_top_comp_cdf
import Theorems.Thm_BookProof_ChapterDiffuseUnitaryModel_cdfUnitary_intertwines
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_coeFn
open BookProof.ChapterDiffuseUnitaryModel



noncomputable section

open MeasureTheory ProbabilityTheory Filter


open BookProof.ChapterDiffuseCdfModel BookProof.ChapterLinftyMultiplication

variable (mu : Measure ℝ) [IsProbabilityMeasure mu] [NullSingletonClass mu]

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ U : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1)) ≃ₗᵢ[ℂ] Lp ℂ 2 mu,
      ∀ (g : ℝ → ℂ) (hg : MemLp g ⊤ (volume.restrict (Set.Icc (0 : ℝ) 1)))
        (u : Lp ℂ 2 (volume.restrict (Set.Icc (0 : ℝ) 1))),
        (U (multOp g hg u) : ℝ → ℂ) =ᵐ[mu] fun x => g (cdf mu x) * (U u : ℝ → ℂ) x := by

  refine ⟨cdfUnitary mu, fun g hg u => ?_⟩
  rw [cdfUnitary_intertwines mu hg u]
  exact multOp_coeFn _ _ _
