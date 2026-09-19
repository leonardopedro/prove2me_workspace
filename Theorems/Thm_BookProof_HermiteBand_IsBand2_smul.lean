-- Generated from ChapterHermiteBandCalculus.lean — theorem BookProof.HermiteBand.IsBand2.smul
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand
open BookProof.HermiteBand.IsBand2

variable {d : ℕ}



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

theorem BookProof.HermiteBand.IsBand2.smul {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} (c : ℂ)
    (hT : IsBand2 T) : IsBand2 (c • T) := by sorry
