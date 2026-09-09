-- Generated from ChapterSirkRitzPerturbation.lean — theorem BookProof.RitzPerturbation.minmaxGap_tendsto_of_tendsto
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
open BookProof.RitzPerturbation








noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzPerturbation.minmaxGap_tendsto_of_tendsto {ι : Type*} {l : Filter ι} (Tn : ι → F →L[ℂ] F)
    (T : F →L[ℂ] F) (hne0 : (minmaxSet T 0).Nonempty) (hne1 : (minmaxSet T 1).Nonempty)
    (h : Tendsto (fun i => ‖Tn i - T‖) l (𝓝 0)) :
    Tendsto (fun i => minmaxGap (Tn i)) l (𝓝 (minmaxGap T)) := by sorry
