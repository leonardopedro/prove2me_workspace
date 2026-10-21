-- Generated from ChapterSchurGershgorinGap.lean — solution of BookProof.SchurGershgorin.quadForm_sum
import Mathlib
import Definitions.Def_ChapterSchurGershgorinGap
import Theorems.Thm_BookProof_SchurGershgorin_inner_sum_apply_sum
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTruncationGapLift
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsFockGapChain
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.SchurGershgorin



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.TruncationGapLift
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (H : finiteModeDomain b →ₗ[ℂ] F)
    (S : Finset ℕ) (c : ℕ → ℂ) :
    quadForm H (∑ i ∈ S, c i • bvec b i)
      = (∑ i ∈ S, ∑ j ∈ S, (starRingEnd ℂ) (c i) * c j * entry b H i j).re := by

  have hcoe : ((∑ i ∈ S, c i • bvec b i : finiteModeDomain b) : F) = ∑ i ∈ S, c i • b i := by
    push_cast
    rfl
  simp only [quadForm, hcoe]
  rw [inner_sum_apply_sum]
