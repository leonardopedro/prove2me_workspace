-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.minmaxGap_tendsto_of_tendsto
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_minmaxLevel_tendsto_of_tendsto
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} {l : Filter ι} (Tn : ι → F →L[ℂ] F)
    (T : F →L[ℂ] F) (hne0 : (minmaxSet T 0).Nonempty) (hne1 : (minmaxSet T 1).Nonempty)
    (h : Tendsto (fun i => ‖Tn i - T‖) l (𝓝 0)) :
    Tendsto (fun i => minmaxGap (Tn i)) l (𝓝 (minmaxGap T)) := by

  have h0 := minmaxLevel_tendsto_of_tendsto Tn T 0 hne0 h
  have h1 := minmaxLevel_tendsto_of_tendsto Tn T 1 hne1 h
  simpa [minmaxGap] using h1.sub h0
