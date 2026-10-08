-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.isBand1_momPoly
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.HermiteBand



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}


theorem BookProof.HermiteBand.isBand1_momPoly (i : Fin d) : IsBand1 (momPoly i) := by sorry
