-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.inSector_smul
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} {u : FockAlg} (c : ℂ) (hu : InSector n u) :
    InSector n (c • u) := fun α hα => hu α (Finsupp.support_smul hα)
