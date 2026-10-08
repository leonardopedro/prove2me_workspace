-- Generated from ChapterNsOuterFockFarisLavine.lean — theorem BookProof.NsOuterFock.ns_interaction_nontrivial
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Definitions.Def_ChapterSqSumOuterFamily
import Mathlib
import Definitions.Def_ChapterNsOuterFockFarisLavine
open BookProof.NsOuterFock



open Finset MvPolynomial
open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.HermiteProductCore BookProof.QgHermiteOscillator
open BookProof.QgOuterFock BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL
open BookProof.SqSumOuterFamily

noncomputable section

variable (bv : Fin 3 → ℝ) (nu lam mu gg : ℝ)

theorem BookProof.NsOuterFock.ns_interaction_nontrivial {n : ℕ} (hn : 2 ≤ n) (hlam : lam ≠ 0) :
    ∃ (r : Fin n × NsLoc) (I : Fin (n * 18)),
      parcelOf I ≠ r.1 ∧ nsVec bv nu lam mu gg n r I ≠ 0 := by sorry
