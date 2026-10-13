-- Generated from ChapterFockSchurEsa.lean — solution of BookProof.FockSchur.sum_normSq_annA_of_sector
import Mathlib
import Definitions.Def_ChapterFockSchurEsa
import Theorems.Thm_BookProof_FockSchur_normSq_toLp
import Theorems.Thm_BookProof_FockSchur_sum_normSq_annA
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
theorem solution {n : ℕ} {u : FockAlg} (hu : InSector n u) {L : Finset ℕ}
    (hL : modes u ⊆ L) : ∑ k ∈ L, ‖toLp (annA k u)‖ ^ 2 = (n : ℝ) * ‖toLp u‖ ^ 2 := by

  rw [sum_normSq_annA hL, normSq_toLp, Finset.mul_sum]
  exact Finset.sum_congr rfl fun α hα => by rw [hu α hα]
