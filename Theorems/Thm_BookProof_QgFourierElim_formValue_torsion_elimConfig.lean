-- Generated from ChapterQgFourierElimination.lean — theorem BookProof.QgFourierElim.formValue_torsion_elimConfig
import Definitions.Def_ChapterScalaronFiberFL
import Definitions.Def_ChapterScalaronOuterFockFL
import Definitions.Def_ChapterQgVielbeinModeInstance
import Definitions.Def_ChapterQgContinuumModeInstance
import Definitions.Def_ChapterQgBrstDerivativeGauge
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
open BookProof.QgFourierElim



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgFourierElim.formValue_torsion_elimConfig (k : Mom) (z : Fin 3 × Fin 3 → ℂ) (mu nu i : Fin 3) :
    formValue k (torsionF mu nu i) (elimConfig k z)
      = Complex.I * (((k mu : ℤ) : ℂ) * z (nu, i) - ((k nu : ℤ) : ℂ) * z (mu, i)) := by sorry
