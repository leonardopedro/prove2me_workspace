-- Generated from ChapterSmFockEsa.lean — theorem BookProof.SmFockEsa.smSectorHam_eq_weylPoly
import Definitions.Def_ChapterSmFockEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib

open MvPolynomial
open BookProof.SmOuterFock BookProof.SmHamiltonian
open BookProof.YangMillsNonAbelianEsa

noncomputable section

theorem BookProof.SmFockEsa.smSectorHam_eq_weylPoly (P : SmParams) (n : ℕ) :
    smSectorHam P n = weylPoly (smSecMomIdx n) (smSecFieldPoly P n) := by sorry
