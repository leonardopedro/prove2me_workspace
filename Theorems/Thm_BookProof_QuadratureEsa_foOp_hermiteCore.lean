-- Generated from ChapterQuadratureEsa.lean — theorem BookProof.QuadratureEsa.foOp_hermiteCore
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



open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}


theorem BookProof.QuadratureEsa.foOp_hermiteCore (b b' : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    foOp b b' (hermiteCore a)
      = ∑ i, ((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
                • hermiteMvLp (a + Finsupp.single i 1)
              + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
                • hermiteMvLp (a - Finsupp.single i 1)) := by sorry
