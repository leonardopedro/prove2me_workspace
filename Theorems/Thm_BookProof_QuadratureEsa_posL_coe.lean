-- Generated from ChapterQuadratureEsa.lean — theorem BookProof.QuadratureEsa.posL_coe
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.HermiteProductCore
open BookProof.HermiteRelative
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.QuadratureEsa

variable {d : ℕ}



open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent


theorem BookProof.QuadratureEsa.posL_coe (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    posL i (coreEquiv p) = pgLp (mulXPoly i p) := by sorry
