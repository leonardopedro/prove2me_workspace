-- Generated from ChapterHermiteLadderOrder.lean — theorem BookProof.HermiteLadder.exists_ladderOrd_mulL
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

variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section


theorem BookProof.HermiteLadder.exists_ladderOrd_mulL (q : MvPolynomial (Fin d) ℂ) : ∃ n, LadderOrd (mulL q) n := by sorry
