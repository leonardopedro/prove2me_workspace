-- Generated from ChapterQuantizationWeyl.lean — theorem BookProof.QuantizationWeyl.comm_scaled
import Mathlib
import Definitions.Def_ChapterQuantizationWeyl
open BookProof.QuantizationWeyl


open NormedSpace
open scoped Matrix


attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

theorem BookProof.QuantizationWeyl.comm_scaled (a b : ℝ) :
    (a • Xgen) * (b • Ygen) - (b • Ygen) * (a • Xgen) = (a * b) • Zgen := by sorry
