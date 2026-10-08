-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.contract_smul_left
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityPolymomentum



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

variable {e T : ℝ} {S Tc : Matrix (Fin 4) (Fin 4) ℝ} {u v : Fin 4 → ℝ}

theorem BookProof.ChapterGravityPolymomentum.contract_smul_left (c : ℝ) (A B : Matrix (Fin 4) (Fin 4) ℝ) :
    contract (c • A) B = c * contract A B := by sorry
