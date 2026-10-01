-- Generated from ChapterHermiteProductBasis.lean — theorem BookProof.HermiteProductBasis.hermiteMvLp_mem_core
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.HermiteProductBasis

variable {d : ℕ}



open MeasureTheory MvPolynomial BookProof.HermiteCore BookProof.HermiteProductCore

noncomputable section


theorem BookProof.HermiteProductBasis.hermiteMvLp_mem_core (a : Fin d →₀ ℕ) : hermiteMvLp a ∈ polyGaussCore (d := d) := by sorry
