-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.conj_foAmp
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b b' : Fin d → ℝ) (i : Fin d) :
    (starRingEnd ℂ) (foAmp b b' i) = ((b i : ℝ) : ℂ) - Complex.I * ((b' i : ℝ) : ℂ) / 2 := by

  simp only [foAmp, map_add, map_div₀, map_mul, Complex.conj_ofReal, Complex.conj_I, map_ofNat]
  ring
