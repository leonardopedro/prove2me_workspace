-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.hn_mono
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_wt_mono
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal
open BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {m m' : ℕ} (h : m ≤ m') (v : L2d d) : hn m v ≤ hn m' v := ENNReal.tsum_le_tsum fun a => mul_le_mul_left (wt_mono h a) _
