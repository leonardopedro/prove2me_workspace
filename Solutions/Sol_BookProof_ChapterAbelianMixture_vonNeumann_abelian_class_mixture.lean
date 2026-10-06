-- Generated from ChapterAbelianMixture.lean — solution of BookProof.ChapterAbelianMixture.vonNeumann_abelian_class_mixture
import Mathlib
import Definitions.Def_ChapterAbelianMixture
open BookProof.ChapterAbelianMixture



noncomputable section

open MeasureTheory ENNReal

set_option maxHeartbeats 1000000 in
theorem solution :
    (multOp (μ := vonNeumann_abelian_class_Linfty
