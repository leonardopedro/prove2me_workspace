-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.inSector_add
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} {u v : FockAlg} (hu : InSector n u) (hv : InSector n v) :
    InSector n (u + v) := by

  intro α hα
  rcases Finset.mem_union.mp (Finsupp.support_add hα) with h | h
  · exact hu α h
  · exact hv α h
