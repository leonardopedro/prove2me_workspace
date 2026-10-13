-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.not_summable_inv_sqrt
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
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

theorem solution : ¬ Summable (fun N : ℕ => (Real.sqrt ((N : ℝ) + 1))⁻¹) := by
  intro h
  have h2 : Summable (fun N : ℕ => 1 / ((N : ℝ) + 1)) := by
    refine Summable.of_nonneg_of_le (fun N => by positivity) (fun N => ?_) h
    rw [one_div, inv_le_inv₀ (by positivity) (by positivity)]
    nlinarith [Real.sq_sqrt (by positivity : (0 : ℝ) ≤ (N : ℝ) + 1), Real.sqrt_nonneg ((N : ℝ) + 1)]
  refine Real.not_summable_one_div_natCast ?_
  refine (summable_nat_add_iff 1).mp ?_
  simpa using h2
