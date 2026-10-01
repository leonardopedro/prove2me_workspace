-- Generated from ChapterHermiteProductBasis.lean — theorem BookProof.HermiteProductBasis.pgMap_apply
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.HermiteProductBasis

variable {d : ℕ}



open MeasureTheory MvPolynomial BookProof.HermiteCore BookProof.HermiteProductCore

noncomputable section


theorem BookProof.HermiteProductBasis.pgMap_apply (p : MvPolynomial (Fin d) ℂ) : pgMap p = pgLp p := by sorry
