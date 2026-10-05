-- Generated from ChapterQuadratureEsa.lean — theorem BookProof.QuadratureEsa.phaseU_foOp_hermiteCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
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


theorem BookProof.QuadratureEsa.phaseU_foOp_hermiteCore (b b' : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    phaseU (foPhase b b') (norm_foPhase b b') (foOp (foMod b b') 0 (hermiteCore a))
      = foOp b b' (phaseCore (foPhase b b') (norm_foPhase b b') (hermiteCore a)) := by sorry
