-- Generated from ChapterHermiteGalerkinFriedrichs.lean — solution of BookProof.HermiteGalerkin.isUnit_algebraMap_sub
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.HermiteGalerkin




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) {z : ℂ} (hz : z.im ≠ 0) :
    IsUnit (algebraMap ℂ (F →L[ℂ] F) z - T) := by

  have hspec : z ∉ spectrum ℂ T := by
    intro hmem
    exact hz (by rw [← hT.spectrumRestricts.rightInvOn hmem]; simp)
  simpa [spectrum.mem_iff] using hspec
