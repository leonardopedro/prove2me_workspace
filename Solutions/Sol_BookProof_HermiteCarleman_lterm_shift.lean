-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.lterm_shift
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

theorem solution (i : Fin d) (b : Fin d →₀ ℕ) :
    lterm u amp i (b + Finsupp.single i 1) = (starRingEnd ℂ) (rterm u amp i b) := by
  rw [lterm, rterm]
  simp only [map_mul, Complex.conj_conj, Finsupp.coe_add, Pi.add_apply,
    Finsupp.single_eq_same, Complex.conj_ofReal]
  rw [add_tsub_cancel_right]
  push_cast
  ring
