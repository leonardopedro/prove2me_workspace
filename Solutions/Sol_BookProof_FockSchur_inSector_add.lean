-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.inSector_add
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSchur




open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} {u v : FockAlg} (hu : InSector n u) (hv : InSector n v) :
    InSector n (u + v) := by

  intro α hα
  rcases Finset.mem_union.mp (Finsupp.support_add hα) with h | h
  · exact hu α h
  · exact hv α h
