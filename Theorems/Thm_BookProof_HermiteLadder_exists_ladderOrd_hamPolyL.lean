-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.exists_ladderOrd_hamPolyL
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.HermiteLadder



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}


theorem BookProof.HermiteLadder.exists_ladderOrd_hamPolyL (S : Finset (Fin d)) (q : MvPolynomial (Fin d) ℂ) :
    ∃ n, LadderOrd (hamPolyL S q) n := by sorry
