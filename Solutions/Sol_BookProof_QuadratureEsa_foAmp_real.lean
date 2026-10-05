-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.foAmp_real
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

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (r : Fin d → ℝ) (i : Fin d) : foAmp r 0 i = ((r i : ℝ) : ℂ) := by

  simp [foAmp]
