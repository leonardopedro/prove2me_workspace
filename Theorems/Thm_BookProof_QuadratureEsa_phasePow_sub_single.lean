-- Generated from ChapterQuadratureEsa.lean — theorem BookProof.QuadratureEsa.phasePow_sub_single
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
open BookProof.QuadratureEsa



open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}


theorem BookProof.QuadratureEsa.phasePow_sub_single (zeta : Fin d → ℂ) {i : Fin d} {a : Fin d →₀ ℕ} (ha : 0 < a i) :
    phasePow zeta (a - Finsupp.single i 1) * zeta i = phasePow zeta a := by sorry
