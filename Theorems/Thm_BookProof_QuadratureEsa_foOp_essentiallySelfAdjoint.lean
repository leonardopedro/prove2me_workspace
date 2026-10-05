-- Generated from ChapterQuadratureEsa.lean — theorem BookProof.QuadratureEsa.foOp_essentiallySelfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.HermiteRelative
open BookProof.QuadratureEsa

variable {d : ℕ}



open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent


theorem BookProof.QuadratureEsa.foOp_essentiallySelfAdjoint (b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (foOp b b') := by sorry
