-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.wave_indefiniteQuadratic_firstOrder_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Theorems.Thm_BookProof_HermiteCarleman_mixOp_essentiallySelfAdjoint
open BookProof.HermiteCarleman




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ} {lam : (Fin d →₀ ℕ) → ℝ} {amp : Fin d → ℂ} {z : ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ)
    (b b' : Fin (1 + n) → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 1 + n)) (mixOp (minkowskiCoeff n) b b') := mixOp_essentiallySelfAdjoint _ b b'
