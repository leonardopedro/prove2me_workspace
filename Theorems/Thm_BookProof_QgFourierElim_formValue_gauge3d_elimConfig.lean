-- Generated from ChapterQgFourierElimination.lean — theorem BookProof.QgFourierElim.formValue_gauge3d_elimConfig
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
import Definitions.Def_ChapterA4
open BookProof.QgFourierElim



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

theorem BookProof.QgFourierElim.formValue_gauge3d_elimConfig (k : Mom) (z : Fin 3 × Fin 3 → ℂ) (i : Fin 3) :
    formValue k (gauge3dF i) (elimConfig k z)
      = ∑ mu : Fin 3, Complex.I * ((k mu : ℤ) : ℂ) * z (mu, i) := by sorry
