-- Generated from ChapterPolarPartialIsometry.lean — theorem BookProof.PolarPartialIsometry.norm_polarIsom_of_mem
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterPolarPartialIsometry
open BookProof.PolarPartialIsometry



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {Dom : Submodule ℂ F}

variable (P Q : Dom →ₗ[ℂ] F)
  (h : ∀ x y : Dom, (inner ℂ (P x) (P y) : ℂ) = inner ℂ (Q x) (Q y))
variable [CompleteSpace F]

theorem BookProof.PolarPartialIsometry.norm_polarIsom_of_mem {z : F} (hz : z ∈ initSpace P) : ‖polarIsom P Q h z‖ = ‖z‖ := by sorry
