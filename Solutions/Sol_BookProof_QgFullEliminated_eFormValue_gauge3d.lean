-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.eFormValue_gauge3d
import Mathlib
import Definitions.Def_ChapterQgFullEliminated
import Theorems.Thm_BookProof_QgFullEliminated_sum_eind_mul
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterQgFourierElimination
open BookProof.QgFullEliminated




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa BookProof.ScalaronEsa
open BookProof.QgVielbeinScalaronGaugeFL BookProof.QgFourierElim

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (i : Fin 3) (z : EComp → ℂ) :
    eFormValue k (gauge3dF i) z = ∑ mu : Fin 3, Complex.I * ((k mu : ℤ) : ℂ) * z (mu, i) := by

  have h : ∀ c : EComp, elimCoef k (gauge3dF i) c * z c
      = ∑ mu : Fin 3, (Complex.I * ((k mu : ℤ) : ℂ)) * (eind c (mu, i) * z c) := by
    intro c
    rw [elimCoef_gauge3d, Finset.sum_mul]
    exact Finset.sum_congr rfl fun mu _ => by ring
  rw [eFormValue, Finset.sum_congr rfl fun c _ => h c, Finset.sum_comm]
  refine Finset.sum_congr rfl fun mu _ => ?_
  rw [← Finset.mul_sum, sum_eind_mul]
