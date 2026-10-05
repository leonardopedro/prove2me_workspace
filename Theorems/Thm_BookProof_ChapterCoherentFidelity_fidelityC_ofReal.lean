-- Generated from ChapterCoherentFidelity.lean — theorem BookProof.ChapterCoherentFidelity.fidelityC_ofReal
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterCoherentFidelity
import Definitions.Def_ChapterCoherentOverlapComplex
import Definitions.Def_ChapterSoftmaxBorn
open BookProof.ChapterCoherentOverlapComplex
open BookProof.ChapterSoftmaxBorn
open BookProof.ChapterCoherentFidelity

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterCoherentFidelity.fidelityC_ofReal (q k : EuclideanSpace ℝ (Fin n)) :
    fidelityC (ofRealVec q) (ofRealVec k) = Real.exp (-‖q - k‖ ^ 2) := by sorry
