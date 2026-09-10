-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.support_subset_modes
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {u : FockAlg} {β : Conf} (h : β ∈ u.support) :
    β.support ⊆ modes u := fun _ hi => Finset.mem_biUnion.mpr ⟨β, h, hi⟩
