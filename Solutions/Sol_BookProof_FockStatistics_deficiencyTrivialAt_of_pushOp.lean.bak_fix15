-- Generated from ChapterFockStatisticsEsa.lean — solution of BookProof.FockStatistics.deficiencyTrivialAt_of_pushOp
import Mathlib
import Definitions.Def_ChapterFockStatisticsEsa
import Theorems.Thm_BookProof_GraphCore_pushOp_apply
open BookProof.FockStatistics




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm BookProof.PermSector
open BookProof.SecondQuantizationCore BookProof.EsaOneParticle BookProof.DirectSumEsa

noncomputable section

variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

set_option maxHeartbeats 1000000 in
theorem solution (U : F →ₗᵢ[ℂ] G) {D : Submodule ℂ F} (T : D →ₗ[ℂ] F)
    {z : ℂ} (h : DeficiencyTrivialAt (pushDom U D) (pushOp U T) z) :
    DeficiencyTrivialAt D T z := by

  intro w hw
  have hUw : U w = 0 := by
    refine h (U w) (fun V => ?_)
    obtain ⟨v₀, hv₀, hV⟩ := V.2
    have hx : (V : G) = U ((⟨v₀, hv₀⟩ : D) : F) := hV.symm
    rw [pushOp_apply U T V ⟨v₀, hv₀⟩ hx, hx, U.inner_map_map, U.inner_map_map]
    exact hw ⟨v₀, hv₀⟩
  exact U.injective (by rw [hUw, map_zero])
