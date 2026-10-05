-- Generated from ChapterFockSchurEsa.lean — theorem BookProof.FockSchur.sum_normSq_annA_of_sector
import Definitions.Def_ChapterCoreBoundsEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockSchur



open BookProof.FockSecondQuantization BookProof.CoreBounds
open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsFriedrichs

noncomputable section

theorem BookProof.FockSchur.sum_normSq_annA_of_sector {n : ℕ} {u : FockAlg} (hu : InSector n u) {L : Finset ℕ}
    (hL : modes u ⊆ L) : ∑ k ∈ L, ‖toLp (annA k u)‖ ^ 2 = (n : ℝ) * ‖toLp u‖ ^ 2 := by sorry
