-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.qgElimFull_esa_core_fl
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_QgOuterFockCoreFL_CoreData_esa_on_core
import Theorems.Thm_BookProof_QgOuterFockCoreFL_commForm_congr
import Theorems.Thm_BookProof_QgOuterFockCoreFL_quadForm_congr
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secData_coreN
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_commForm_le
import Theorems.Thm_BookProof_ScalaronOuterFockFL_secHam_symmetricOn
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (secCore (ι := by

  refine (secData W (qgElimFullModes g)).esa_on_core (secHam_symmetricOn W _)
    (c := 6 * (qgElimFullModes g).K) (by have := (qgElimFullModes g).K_nonneg; linarith) ?_
  intro p
  have hc : commForm (secData W (qgElimFullModes g)).H₀ (secData W (qgElimFullModes g)).coreN p
      = commForm (secHam W (qgElimFullModes g)) (secDiag W (qgElimFullModes g)) p :=
    commForm_congr _ _ _ _ _ _ rfl (secData_coreN W (qgElimFullModes g) p)
  have hq : quadForm (secData W (qgElimFullModes g)).coreN p
      = quadForm (secDiag W (qgElimFullModes g)) p :=
    quadForm_congr _ _ _ _ rfl (secData_coreN W (qgElimFullModes g) p)
  rw [hc, hq]
  exact secHam_commForm_le W (qgElimFullModes g) p
