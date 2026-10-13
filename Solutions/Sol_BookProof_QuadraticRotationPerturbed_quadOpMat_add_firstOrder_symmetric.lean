-- Generated from ChapterQuadraticRotationPerturbed.lean — solution of BookProof.QuadraticRotationPerturbed.quadOpMat_add_firstOrder_symmetric
import Mathlib
import Definitions.Def_ChapterQuadraticRotationPerturbed
import Theorems.Thm_BookProof_KatoRellich_symmetricOn_add
import Theorems.Thm_BookProof_QuadraticRotation_quadOpMat_symmetric
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesSignFlip
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterKatoRellichDeficiency
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
open BookProof.QuadraticRotationPerturbed




open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.NavierStokesFlow.SignFlip
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadraticRotation
open BookProof.KatoRellich
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {A : Matrix (Fin d) (Fin d) ℝ}
    (hA : A.IsHermitian) (b b' : Fin d → ℝ) :
    SymmetricOn (polyGaussCore (d := d)) (quadOpMat A + foOp b b') := symmetricOn_add (quadOpMat_symmetric hA) (foOp_symmetric b b')
