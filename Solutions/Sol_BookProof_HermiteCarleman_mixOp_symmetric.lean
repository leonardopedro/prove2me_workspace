-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.mixOp_symmetric
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_quadOp_symmetric
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQuadratureEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterHyperbolicQuadraticEsa
open BookProof.HermiteCarleman




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ} {lam : (Fin d →₀ ℕ) → ℝ} {amp : Fin d → ℂ} {z : ℂ}

set_option maxHeartbeats 1000000 in

theorem solution (c b b' : Fin d → ℝ) :
    SymmetricOn (polyGaussCore (d := d)) (mixOp c b b') := by
  intro x y
  rw [mixOp, LinearMap.add_apply, LinearMap.add_apply, inner_add_left, inner_add_right,
    quadOp_symmetric c x y, foOp_symmetric b b' x y]
