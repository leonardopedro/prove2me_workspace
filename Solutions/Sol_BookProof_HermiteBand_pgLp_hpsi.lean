-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.pgLp_hpsi
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
open BookProof.HermiteBand








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (α : Fin d →₀ ℕ) : pgLp (hpsi α) = hermiteMvLp α := by

  rw [hpsi, hermiteMvLp, ← HermiteProductCore.pgMap_apply, map_smul,
    HermiteProductCore.pgMap_apply]
