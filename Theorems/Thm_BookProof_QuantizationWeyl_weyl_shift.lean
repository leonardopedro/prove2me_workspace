-- Generated from ChapterQuantizationWeyl.lean — theorem BookProof.QuantizationWeyl.weyl_shift
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl


open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

theorem BookProof.QuantizationWeyl.weyl_shift (a b : ℝ) :
    NormedSpace.exp (a • Xgen) * NormedSpace.exp (b • Ygen) * NormedSpace.exp (-(a • Xgen))
      = NormedSpace.exp (b • Ygen + (a * b) • Zgen) := by sorry
