-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.isBand1_foPoly
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteRelativeBound
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.HermiteRelative
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.HermiteBand



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}


theorem BookProof.HermiteBand.isBand1_foPoly (b b' : Fin d → ℝ) : IsBand1 (BookProof.HermiteRelative.foPoly b b') := by sorry
