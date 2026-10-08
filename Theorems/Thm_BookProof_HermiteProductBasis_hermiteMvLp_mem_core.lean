-- Generated from ChapterHermiteProductBasis.lean — theorem BookProof.HermiteProductBasis.hermiteMvLp_mem_core
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.HermiteProductBasis



open MeasureTheory MvPolynomial BookProof.HermiteCore BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}


theorem BookProof.HermiteProductBasis.hermiteMvLp_mem_core (a : Fin d →₀ ℕ) : hermiteMvLp a ∈ polyGaussCore (d := d) := by sorry
