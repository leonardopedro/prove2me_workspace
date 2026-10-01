-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.isBand2_fqQuadPoly
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterYangMillsHermite
open BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.YangMillsHermite
open BookProof.HermiteBand

variable {d : ℕ}



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis


theorem BookProof.HermiteBand.isBand2_fqQuadPoly (P Q S : Fin d → Fin d → ℝ) : IsBand2 (fqQuadPoly P Q S) := by sorry
