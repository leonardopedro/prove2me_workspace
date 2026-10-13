-- Generated from ChapterSmComparison.lean — solution of BookProof.SmComparison.smConfField_symmetricOn
import Mathlib
import Definitions.Def_ChapterSmComparison
import Theorems.Thm_BookProof_SmComparison_realCoeff_smConfPoly
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterYangMillsFriedrichs
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
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
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
open BookProof.ChapterF7
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin 160) :
    SymmetricOn (polyGaussCore (d := 163))
      ((polyGaussCore (d := 163)).subtype.comp (smConfField s)) := (coreRepPoly 163).symmetricOn_op (mulOp_polySym (realCoeff_smConfPoly _))
