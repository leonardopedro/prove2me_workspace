-- Generated from ChapterQgFullEliminated.lean — solution of BookProof.QgFullEliminated.eFormValue_torsion
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
theorem solution (k : Mom) (mu nu i : Fin 3) (z : EComp → ℂ) :
    eFormValue k (torsionF mu nu i) z
      = Complex.I * ((k mu : ℤ) : ℂ) * z (nu, i) - Complex.I * ((k nu : ℤ) : ℂ) * z (mu, i) := by

  have h : ∀ c : EComp, elimCoef k (torsionF mu nu i) c * z c
      = (Complex.I * ((k mu : ℤ) : ℂ)) * (eind c (nu, i) * z c)
        - (Complex.I * ((k nu : ℤ) : ℂ)) * (eind c (mu, i) * z c) := by
    intro c
    rw [elimCoef_torsion]
    ring
  rw [eFormValue, Finset.sum_congr rfl fun c _ => h c, Finset.sum_sub_distrib,
    ← Finset.mul_sum, ← Finset.mul_sum, sum_eind_mul, sum_eind_mul]
