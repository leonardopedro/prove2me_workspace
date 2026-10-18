-- Generated from ChapterSmComparison.lean — solution of BookProof.SmComparison.sm_N_positive
import Mathlib
import Definitions.Def_ChapterSmComparison
import Theorems.Thm_BookProof_SmComparison_smConfField_symmetricOn
import Theorems.Thm_BookProof_SmComparison_smComparison_quadForm
import Theorems.Thm_BookProof_SmHamiltonian_smPi_symmetricOn
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterWallEsaBddBelow
import Definitions.Def_ChapterTensorSumChain
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.SmComparison




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.ScalaronWallEsa BookProof.ScalaronEsa BookProof.WallEsaBddBelow
open BookProof.TensorSumChain BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.EsaClosure BookProof.GraphCore
open BookProof.StoneBridge BookProof.ChapterStoneResolvent
open MeasureTheory
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {c0 : ℝ} (hc0 : 1 ≤ c0) (x : polyGaussCore (d := 163)) :
    ‖((x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 ≤ quadForm (smComparison c0) x := by

  have hnn : 0 ≤ quadForm (weylOp smPi smConfField) x :=
    weylOpDom_quadForm_nonneg smPi_symmetricOn smConfField_symmetricOn x
  have hx : (0 : ℝ) ≤ ‖((x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 := by positivity
  rw [smComparison_quadForm]
  nlinarith
